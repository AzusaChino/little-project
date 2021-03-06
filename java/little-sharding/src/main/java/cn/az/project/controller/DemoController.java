package cn.az.project.controller;

import cn.az.project.service.IDemoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author az
 * @since 11/17/20
 */
@RestController
@RequestMapping("/demo")
public class DemoController {

    @Autowired
    @Qualifier("firstDemoService")
    private IDemoService firstDemoService;

    @Autowired
    @Qualifier("secondDemoService")
    private IDemoService secondDemoService;


    @GetMapping("mysql")
    public ResponseEntity<?> getFirst() {
        return ResponseEntity.ok(firstDemoService.getFirst());
    }

    @GetMapping("pg")
    public ResponseEntity<?> getSecond() {
        return ResponseEntity.ok(secondDemoService.getSecond());
    }
}
